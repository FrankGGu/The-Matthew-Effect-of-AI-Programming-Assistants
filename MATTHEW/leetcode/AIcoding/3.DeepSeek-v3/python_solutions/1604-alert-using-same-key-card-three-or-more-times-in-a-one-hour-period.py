from collections import defaultdict

class Solution:
    def alertNames(self, keyName: List[str], keyTime: List[str]) -> List[str]:
        def time_to_minutes(time_str):
            hh, mm = map(int, time_str.split(':'))
            return hh * 60 + mm

        name_to_times = defaultdict(list)
        for name, time in zip(keyName, keyTime):
            name_to_times[name].append(time_to_minutes(time))

        res = []
        for name in sorted(name_to_times.keys()):
            times = sorted(name_to_times[name])
            for i in range(len(times) - 2):
                if times[i+2] - times[i] <= 60:
                    res.append(name)
                    break
        return res