#include <vector>
#include <string>

class Solution {
public:
    std::vector<std::string> addOperators(std::string num, int target) {
        this->num = num;
        this->target = target;
        result.clear();
        if (!num.empty()) {
            backtrack(0, "", 0, 0);
        }
        return result;
    }

private:
    std::vector<std::string> result;
    std::string num;
    int target;

    void backtrack(int index, const std::string& path, long long current_eval, long long prev_num) {
        if (index == num.length()) {
            if (current_eval == target) {
                result.push_back(path);
            }
            return;
        }

        long long current_num = 0;
        std::string current_num_str;
        for (int i = index; i < num.length(); ++i) {
            if (i > index && num[index] == '0') {
                break;
            }

            current_num_str += num[i];
            current_num = current_num * 10 + (num[i] - '0');

            if (index == 0) {
                backtrack(i + 1, current_num_str, current_num, current_num);
            } else {
                backtrack(i + 1, path + "+" + current_num_str, current_eval + current_num, current_num);
                backtrack(i + 1, path + "-" + current_num_str, current_eval - current_num, -current_num);
                backtrack(i + 1, path + "*" + current_num_str, current_eval - prev_num + prev_num * current_num, prev_num * current_num);
            }
        }
    }
};