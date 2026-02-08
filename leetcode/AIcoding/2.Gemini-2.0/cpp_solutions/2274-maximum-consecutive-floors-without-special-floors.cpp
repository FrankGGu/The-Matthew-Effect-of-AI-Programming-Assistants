#include <algorithm>
#include <vector>

using namespace std;

class Solution {
 public:
  int maxConsecutive(int bottom, int top, vector<int>& special) {
    sort(special.begin(), special.end());
    int max_consecutive = max(special[0] - bottom, top - special.back());
    for (int i = 1; i < special.size(); ++i) {
      max_consecutive = max(max_consecutive, special[i] - special[i - 1] - 1);
    }
    return max_consecutive;
  }
};