#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string guessYear(string date) {
        unordered_map<string, string> dynastyMap = {
            {"公元前", "周"},
            {"前3世纪", "秦"},
            {"前2世纪", "汉"},
            {"589年", "隋"},
            {"618年", "唐"},
            {"960年", "宋"},
            {"1279年", "元"},
            {"1368年", "明"},
            {"1644年", "清"}
        };

        for (const auto& pair : dynastyMap) {
            if (date.find(pair.first) != string::npos) {
                return pair.second;
            }
        }

        return "未知";
    }
};