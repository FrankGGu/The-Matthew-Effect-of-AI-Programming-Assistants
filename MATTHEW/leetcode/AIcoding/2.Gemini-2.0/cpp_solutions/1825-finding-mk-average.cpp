#include <vector>
#include <deque>
#include <numeric>

using namespace std;

class MKAverage {
public:
    MKAverage(int m, int k) : m_(m), k_(k) {}

    void addElement(int num) {
        q_.push_back(num);
        if (q_.size() > m_) {
            q_.pop_front();
        }
    }

    int calculateMKAverage() {
        if (q_.size() < m_) {
            return -1;
        }

        vector<int> sorted_q = vector<int>(q_.begin(), q_.end());
        sort(sorted_q.begin(), sorted_q.end());

        long long sum = 0;
        for (int i = k_; i < m_ - k_; ++i) {
            sum += sorted_q[i];
        }

        return sum / (m_ - 2 * k_);
    }

private:
    int m_;
    int k_;
    deque<int> q_;
};