from typing import List
from collections import defaultdict

class Solution:
    def highAccessEmployees(self, access_log: List[List[str]]) -> List[str]:
        log = defaultdict(list)
        for name, time in access_log:
            log[name].append(int(time))

        result = []
        for name in log:
            times = sorted(log[name])
            for i in range(len(times) - 2):
                if times[i + 2] - times[i] <= 99:
                    result.append(name)
                    break
        return result