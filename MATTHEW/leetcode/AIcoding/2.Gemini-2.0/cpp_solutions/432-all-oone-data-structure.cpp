#include <string>
#include <unordered_map>
#include <list>

using namespace std;

class AllOne {
public:
    AllOne() {}

    void inc(string key) {
        if (keyCount.find(key) == keyCount.end()) {
            keyCount[key] = 1;
            if (buckets.empty() || buckets.front().count != 1) {
                buckets.push_front({1, {key}});
            } else {
                buckets.front().keys.insert(key);
            }
            keyBucket[key] = buckets.begin();
        } else {
            int count = keyCount[key];
            keyCount[key]++;
            auto bucketIter = keyBucket[key];
            bucketIter->keys.erase(key);

            auto nextBucketIter = next(bucketIter);
            if (nextBucketIter == buckets.end() || nextBucketIter->count != count + 1) {
                nextBucketIter = buckets.insert(next(bucketIter), {count + 1, {key}});
            } else {
                nextBucketIter->keys.insert(key);
            }
            keyBucket[key] = nextBucketIter;

            if (bucketIter->keys.empty()) {
                buckets.erase(bucketIter);
            }
        }
    }

    void dec(string key) {
        if (keyCount.find(key) == keyCount.end()) {
            return;
        }

        int count = keyCount[key];
        keyCount[key]--;

        auto bucketIter = keyBucket[key];
        bucketIter->keys.erase(key);

        if (count == 1) {
            keyCount.erase(key);
            keyBucket.erase(key);
        } else {
            auto prevBucketIter = prev(bucketIter);
            if (bucketIter == buckets.begin() || prevBucketIter->count != count - 1) {
                prevBucketIter = buckets.insert(bucketIter, {count - 1, {key}});
            } else {
                prevBucketIter->keys.insert(key);
            }
            keyBucket[key] = prevBucketIter;
        }

        if (bucketIter->keys.empty()) {
            buckets.erase(bucketIter);
        }

        if (keyCount[key] == 0) {
            keyCount.erase(key);
            keyBucket.erase(key);
        }
    }

    string getMaxKey() {
        if (buckets.empty()) {
            return "";
        }
        return *buckets.back().keys.begin();
    }

    string getMinKey() {
        if (buckets.empty()) {
            return "";
        }
        return *buckets.front().keys.begin();
    }

private:
    struct Bucket {
        int count;
        unordered_set<string> keys;
    };

    list<Bucket> buckets;
    unordered_map<string, int> keyCount;
    unordered_map<string, list<Bucket>::iterator> keyBucket;
};