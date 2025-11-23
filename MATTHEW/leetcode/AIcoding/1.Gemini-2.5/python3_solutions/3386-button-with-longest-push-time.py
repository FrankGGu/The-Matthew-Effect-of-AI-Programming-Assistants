class Solution:
    def slowestKey(self, releaseTimes: list[int], keysPressed: str) -> str:
        max_duration = releaseTimes[0]
        result_key = keysPressed[0]

        for i in range(1, len(releaseTimes)):
            current_duration = releaseTimes[i] - releaseTimes[i-1]
            if current_duration > max_duration:
                max_duration = current_duration
                result_key = keysPressed[i]
            elif current_duration == max_duration:
                result_key = max(result_key, keysPressed[i])

        return result_key