#include <vector>
#include <string>
#include <numeric>

class Solution {
public:
    int calPoints(std::vector<std::string>& operations) {
        std::vector<int> record;

        for (const std::string& op : operations) {
            if (op == "+") {
                int last1 = record.back();
                int last2 = record[record.size() - 2];
                record.push_back(last1 + last2);
            } else if (op == "D") {
                record.push_back(2 * record.back());
            } else if (op == "C") {
                record.pop_back();
            } else {
                record.push_back(std::stoi(op));
            }
        }

        int totalSum = 0;
        for (int score : record) {
            totalSum += score;
        }

        return totalSum;
    }
};