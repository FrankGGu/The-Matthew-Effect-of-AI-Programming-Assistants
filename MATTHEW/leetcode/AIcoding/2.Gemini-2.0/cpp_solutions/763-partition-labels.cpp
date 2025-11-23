#include <vector>
#include <string>

using namespace std;

vector<int> partitionLabels(string s) {
    vector<int> last_occurrence(26, 0);
    for (int i = 0; i < s.length(); ++i) {
        last_occurrence[s[i] - 'a'] = i;
    }

    vector<int> result;
    int start = 0;
    int end = 0;
    for (int i = 0; i < s.length(); ++i) {
        end = max(end, last_occurrence[s[i] - 'a']);
        if (i == end) {
            result.push_back(end - start + 1);
            start = i + 1;
        }
    }

    return result;
}