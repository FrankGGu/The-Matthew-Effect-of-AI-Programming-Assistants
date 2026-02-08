class Solution:
    def angleClock(self, hour: int, minutes: int) -> float:
        minute_angle = minutes * 6

        # Adjust hour for 12 o'clock to be 0 for calculation
        # Each hour mark is 30 degrees (360 / 12)
        # Each minute contributes 0.5 degrees to the hour hand (30 / 60)
        hour_angle = (hour % 12 + minutes / 60) * 30

        diff = abs(hour_angle - minute_angle)

        return min(diff, 360 - diff)