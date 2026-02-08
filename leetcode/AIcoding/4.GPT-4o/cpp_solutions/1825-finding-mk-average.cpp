#include <deque>
#include <set>

class MKAverage {
public:
    MKAverage(int m, int k) : m(m), k(k) {}

    void addElement(int num) {
        window.push_back(num);
        if (window.size() > m) {
            int removed = window.front();
            window.pop_front();
            count[removed]--;
            if (count[removed] == 0) {
                count.erase(removed);
            }
        }
        count[num]++;

        if (window.size() == m) {
            while (count.size() > k) {
                auto it = count.begin();
                count.erase(it);
            }
        }
    }

    int calculateMKAverage() {
        if (window.size() < m) return -1;
        long long sum = 0;
        int cnt = 0;
        for (const auto& entry : count) {
            if (cnt >= k) break;
            sum += entry.first * entry.second;
            cnt += entry.second;
        }
        return cnt == k ? sum / (m - 2 * k) : -1;
    }

private:
    int m, k;
    std::deque<int> window;
    std::map<int, int> count;
};