from collections import defaultdict

class Solution:
    def alertNames(self, keyTimes: list[list[str]]) -> list[str]:
        name_times = defaultdict(list)

        for name, time_str in keyTimes:
            h, m = map(int, time_str.split(':'))
            total_minutes = h * 60 + m
            name_times[name].append(total_minutes)

        alert_names = set()

        for name, times in name_times.items():
            times.sort()
            for i in range(len(times) - 2):
                if times[i+2] - times[i] <= 60:
                    alert_names.add(name)
                    break

        return sorted(list(alert_names))