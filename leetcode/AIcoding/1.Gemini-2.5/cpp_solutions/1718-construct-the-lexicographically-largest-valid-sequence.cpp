class Solution {
public:
    std::vector<int> result;
    int N;
    std::vector<bool> used;

    bool backtrack(int index) {
        if (index == 2 * N - 1) {
            return true;
        }

        if (result[index] != 0) {
            return backtrack(index + 1);
        }

        for (int num = N; num >= 1; --num) {
            if (!used[num]) {
                if (num == 1) {
                    result[index] = 1;
                    used[1] = true;
                    if (backtrack(index + 1)) {
                        return true;
                    }
                    used[1] = false;
                    result[index] = 0;
                } else {
                    int second_pos = index + num;
                    if (second_pos < 2 * N - 1 && result[second_pos] == 0) {
                        result[index] = num;
                        result[second_pos] = num;
                        used[num] = true;
                        if (backtrack(index + 1)) {
                            return true;
                        }
                        used[num] = false;
                        result[index] = 0;
                        result[second_pos] = 0;
                    }
                }
            }
        }
        return false;
    }

    std::vector<int> constructDistancedSequence(int n) {
        N = n;
        result.resize(2 * N - 1, 0);
        used.resize(N + 1, false);

        backtrack(0);
        return result;
    }
};