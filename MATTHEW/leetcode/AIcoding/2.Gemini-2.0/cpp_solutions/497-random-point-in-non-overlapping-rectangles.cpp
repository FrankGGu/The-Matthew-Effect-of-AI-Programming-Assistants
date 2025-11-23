#include <vector>
#include <random>

using namespace std;

class Solution {
public:
    Solution(vector<vector<int>>& rects) : rects_(rects) {
        areas_.reserve(rects.size());
        sum_ = 0;
        for (const auto& rect : rects) {
            sum_ += (rect[2] - rect[0] + 1) * (rect[3] - rect[1] + 1);
            areas_.push_back(sum_);
        }
    }

    vector<int> pick() {
        random_device rd;
        mt19937 gen(rd());
        uniform_int_distribution<> distrib(1, sum_);
        int rand_val = distrib(gen);

        int rect_index = upper_bound(areas_.begin(), areas_.end(), rand_val) - areas_.begin();
        const auto& rect = rects_[rect_index];

        uniform_int_distribution<> x_distrib(rect[0], rect[2]);
        uniform_int_distribution<> y_distrib(rect[1], rect[3]);

        return {x_distrib(gen), y_distrib(gen)};
    }

private:
    vector<vector<int>>& rects_;
    vector<int> areas_;
    int sum_;
};