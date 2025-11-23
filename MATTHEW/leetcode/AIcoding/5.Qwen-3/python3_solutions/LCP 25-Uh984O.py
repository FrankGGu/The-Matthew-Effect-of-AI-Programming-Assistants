class Solution:
    def slowestKey(self, releaseTimes: List[int], keysPressed: str) -> str:
        maxDuration = releaseTimes[0]
        result = keysPressed[0]
        for i in range(1, len(releaseTimes)):
            duration = releaseTimes[i] - releaseTimes[i - 1]
            if duration > maxDuration:
                maxDuration = duration
                result = keysPressed[i]
            elif duration == maxDuration:
                if keysPressed[i] < result:
                    result = keysPressed[i]
        return result