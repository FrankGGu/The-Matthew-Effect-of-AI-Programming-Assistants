class Solution {
public:
    vector<int> memLeak(int memory1, int memory2) {
        int time = 0;
        while (memory1 >= time + 1 || memory2 >= time + 1) {
            if (memory1 >= memory2) {
                memory1 -= time + 1;
            } else {
                memory2 -= time + 1;
            }
            time++;
        }
        return {time, memory1, memory2};
    }
};