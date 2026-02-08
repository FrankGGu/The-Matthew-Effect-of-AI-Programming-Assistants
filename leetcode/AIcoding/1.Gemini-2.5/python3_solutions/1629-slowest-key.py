class Solution:
    def slowestKey(self, releaseTimes: list[int], keysPressed: str) -> str:
        max_duration = releaseTimes[0]
        slowest_key = keysPressed[0]

        for i in range(1, len(releaseTimes)):
            current_duration = releaseTimes[i] - releaseTimes[i-1]
            current_key = keysPressed[i]

            if current_duration > max_duration:
                max_duration = current_duration
                slowest_key = current_key
            elif current_duration == max_duration:
                if current_key > slowest_key:
                    slowest_key = current_key

        return slowest_key