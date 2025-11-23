from typing import List

class Solution:
    def minimumProcessingTime(self, processes: List[int], n: int) -> int:
        processes.sort()
        machines = [0] * n
        for time in processes:
            for i in range(n):
                if machines[i] == 0:
                    machines[i] = time
                    break
        return max(machines)