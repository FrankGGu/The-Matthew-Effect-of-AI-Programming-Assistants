#include <unordered_map>
#include <list>

class AllOne {
public:
    AllOne() {}

    void inc(const std::string& key) {
        int count = 0;
        if (keyCount.find(key) != keyCount.end()) {
            count = keyCount[key];
            keyCount[key]++;
            nodeList[count].erase(keyIter[key]);
            if (nodeList[count].empty()) {
                nodeList.erase(count);
                if (minCount == count) minCount++;
            }
        } else {
            keyCount[key] = 1;
            count = 1;
        }

        nodeList[count].push_front(key);
        keyIter[key] = nodeList[count].begin();
        if (minCount > count) minCount = count;
    }

    void dec(const std::string& key) {
        if (keyCount.find(key) == keyCount.end()) return;

        int count = keyCount[key];
        keyCount[key]--;
        nodeList[count].erase(keyIter[key]);
        if (nodeList[count].empty()) {
            nodeList.erase(count);
            if (minCount == count) minCount++;
        }

        if (keyCount[key] == 0) {
            keyCount.erase(key);
        } else {
            nodeList[count - 1].push_front(key);
            keyIter[key] = nodeList[count - 1].begin();
        }
    }

    std::string getMaxKey() {
        if (nodeList.empty()) return "";
        return nodeList.rbegin()->second.front();
    }

    std::string getMinKey() {
        if (nodeList.empty()) return "";
        return nodeList.begin()->second.front();
    }

private:
    std::unordered_map<std::string, int> keyCount;
    std::unordered_map<int, std::list<std::string>> nodeList;
    std::unordered_map<std::string, std::list<std::string>::iterator> keyIter;
    int minCount = 0;
};