#include <set>
#include <queue>
using namespace std;

class MKAverage {
private:
    int m, k;
    queue<int> q;
    multiset<int> left, mid, right;
    long long sum;

    void balance() {
        while (left.size() > k) {
            auto it = prev(left.end());
            mid.insert(*it);
            sum += *it;
            left.erase(it);
        }
        while (right.size() > k) {
            auto it = prev(right.end());
            mid.insert(*it);
            sum += *it;
            right.erase(it);
        }
        while (left.size() < k && !mid.empty()) {
            auto it = mid.begin();
            left.insert(*it);
            sum -= *it;
            mid.erase(it);
        }
        while (right.size() < k && !mid.empty()) {
            auto it = prev(mid.end());
            right.insert(*it);
            sum -= *it;
            mid.erase(it);
        }
    }

public:
    MKAverage(int m, int k) : m(m), k(k), sum(0) {}

    void addElement(int num) {
        if (q.size() == m) {
            int old = q.front();
            q.pop();
            if (left.find(old) != left.end()) {
                left.erase(left.find(old));
            } else if (right.find(old) != right.end()) {
                right.erase(right.find(old));
            } else {
                mid.erase(mid.find(old));
                sum -= old;
            }
        }
        q.push(num);
        if (left.empty() || num <= *left.rbegin()) {
            left.insert(num);
        } else if (right.empty() || num >= *right.begin()) {
            right.insert(num);
        } else {
            mid.insert(num);
            sum += num;
        }
        balance();
    }

    int calculateMKAverage() {
        if (q.size() < m) return -1;
        return sum / (m - 2 * k);
    }
};