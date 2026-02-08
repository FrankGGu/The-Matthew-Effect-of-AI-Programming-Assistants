#include <vector>
#include <string>
#include <stack>

using namespace std;

class Solution {
public:
    vector<int> exclusiveTime(int n, vector<string>& logs) {
        vector<int> result(n, 0);
        stack<int> functionStack;
        int prevTime = 0;

        for (string& log : logs) {
            int functionId, time;
            string type;

            size_t firstColon = log.find(':');
            functionId = stoi(log.substr(0, firstColon));

            size_t secondColon = log.find(':', firstColon + 1);
            type = log.substr(firstColon + 1, secondColon - firstColon - 1);

            time = stoi(log.substr(secondColon + 1));

            if (type == "start") {
                if (!functionStack.empty()) {
                    result[functionStack.top()] += time - prevTime;
                }
                functionStack.push(functionId);
                prevTime = time;
            } else {
                result[functionStack.top()] += time - prevTime + 1;
                functionStack.pop();
                prevTime = time + 1;
            }
        }

        return result;
    }
};