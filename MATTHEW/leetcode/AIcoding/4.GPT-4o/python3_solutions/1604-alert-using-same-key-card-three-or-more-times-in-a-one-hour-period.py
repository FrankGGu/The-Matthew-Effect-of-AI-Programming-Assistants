from collections import defaultdict
from datetime import datetime

class Solution:
    def alertNames(self, keyName: List[str], keyTime: List[str]) -> List[str]:
        time_map = defaultdict(list)

        for name, time in zip(keyName, keyTime):
            time_map[name].append(datetime.strptime(time, "%H:%M"))

        alerts = set()

        for name, times in time_map.items():
            times.sort()
            for i in range(len(times) - 2):
                if (times[i + 2] - times[i]).seconds <= 3600:
                    alerts.add(name)
                    break

        return sorted(alerts)