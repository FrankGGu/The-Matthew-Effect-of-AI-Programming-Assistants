class Solution:
    def slowestKey(self, releaseTimes: List[int], keyPresses: str) -> str:
        maxDuration = releaseTimes[0]
        result = keyPresses[0]
        for i in range(1, len(releaseTimes)):
            duration = releaseTimes[i] - releaseTimes[i - 1]
            if duration > maxDuration:
                maxDuration = duration
                result = keyPresses[i]
            elif duration == maxDuration and keyPresses[i] < result:
                result = keyPresses[i]
        return result