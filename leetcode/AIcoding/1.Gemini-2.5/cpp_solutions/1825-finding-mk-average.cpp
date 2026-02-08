#include <queue>
#include <set>
#include <iterator>

class MKAverage {
public:
    MKAverage(int m, int k) : m(m), k(k), middle_sum(0) {}

    void addElement(int num) {
        q.push_back(num);

        if (q.size() <= m) {
            middle.insert(num);
            middle_sum += num;
            if (q.size() == m) {
                while (low.size() < k) {
                    int val = *middle.begin();
                    middle.erase(middle.begin());
                    middle_sum -= val;
                    low.insert(val);
                }
                while (high.size() < k) {
                    int val = *middle.rbegin();
                    middle.erase(std::prev(middle.end()));
                    middle_sum -= val;
                    high.insert(val);
                }
            }
            return;
        }

        int old_num = q.front();
        q.pop_front();

        if (num < *low.rbegin()) {
            low.insert(num);
        } else if (num > *high.begin()) {
            high.insert(num);
        } else {
            middle.insert(num);
            middle_sum += num;
        }

        if (low.count(old_num)) {
            low.erase(low.find(old_num));
        } else if (high.count(old_num)) {
            high.erase(high.find(old_num));
        } else {
            middle.erase(middle.find(old_num));
            middle_sum -= old_num;
        }

        if (low.size() > k) {
            int val = *low.rbegin();
            low.erase(std::prev(low.end()));
            middle.insert(val);
            middle_sum += val;
        }
        if (high.size() > k) {
            int val = *high.begin();
            high.erase(high.begin());
            middle.insert(val);
            middle_sum += val;
        }
        if (low.size() < k) {
            int val = *middle.begin();
            middle.erase(middle.begin());
            middle_sum -= val;
            low.insert(val);
        }
        if (high.size() < k) {
            int val = *middle.rbegin();
            middle.erase(std::prev(middle.end()));
            middle_sum -= val;
            high.insert(val);
        }
    }

    int calculateMKAverage() {
        if (q.size() < m) {
            return -1;
        }
        return middle_sum / (m - 2 * k);
    }

private:
    int m, k;
    long long middle_sum;
    std::deque<int> q;
    std::multiset<int> low, middle, high;
};