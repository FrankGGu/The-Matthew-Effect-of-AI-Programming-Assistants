#include <vector>
#include <string>

using namespace std;

vector<string> buildArray(vector<int>& target, int n) {
    vector<string> result;
    int current = 1;
    for (int num : target) {
        while (current < num) {
            result.push_back("Push");
            result.push_back("Pop");
            current++;
        }
        result.push_back("Push");
        current++;
    }
    return result;
}