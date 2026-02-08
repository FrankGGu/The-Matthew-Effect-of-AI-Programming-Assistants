from collections import defaultdict

class Solution:
    def alertNames(self, keyName: List[str], keyTime: List[str]) -> List[str]:
        time_dict = defaultdict(list)
        for i in range(len(keyName)):
            name = keyName[i]
            time_str = keyTime[i]
            hour, minute = map(int, time_str.split(':'))
            time_in_minutes = hour * 60 + minute
            time_dict[name].append(time_in_minutes)

        result = []
        for name, times in time_dict.items():
            times.sort()
            for i in range(len(times) - 2):
                if times[i+2] - times[i] <= 60:
                    result.append(name)
                    break

        result.sort()
        return result