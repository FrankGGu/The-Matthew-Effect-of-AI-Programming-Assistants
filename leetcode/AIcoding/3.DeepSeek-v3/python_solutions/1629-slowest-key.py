class Solution:
    def slowestKey(self, releaseTimes: List[int], keysPressed: str) -> str:
        max_duration = releaseTimes[0]
        result = keysPressed[0]

        for i in range(1, len(releaseTimes)):
            duration = releaseTimes[i] - releaseTimes[i-1]
            if duration > max_duration:
                max_duration = duration
                result = keysPressed[i]
            elif duration == max_duration:
                if keysPressed[i] > result:
                    result = keysPressed[i]

        return result