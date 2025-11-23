from collections import defaultdict
import bisect

class Solution:
    def alertNames(self, keyName: List[str], keyTime: List[str]) -> List[str]:
        name_to_times = defaultdict(list)
        for name, time in zip(keyName, keyTime):
            hour, minute = map(int, time.split(':'))
            minutes = hour * 60 + minute
            name_to_times[name].append(minutes)

        result = []
        for name, times in name_to_times.items():
            times.sort()
            for i in range(2, len(times)):
                if times[i] - times[i-2] <= 60:
                    result.append(name)
                    break
        return result