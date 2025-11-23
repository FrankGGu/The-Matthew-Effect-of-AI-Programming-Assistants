import collections

class Solution:
    def maxTotalDamage(self, damage: list[int]) -> int:
        if not damage:
            return 0

        # Find the maximum damage value to determine the size of our auxiliary arrays
        max_val = 0
        for d in damage:
            max_val = max(max_val, d)

        # total_damage_at_value[i] stores the total damage obtained if we choose all spells
        # with damage value 'i'. This is i * (number of times i appears in damage).
        total_damage_at_value = [0] * (max_val + 1)
        counts = collections.Counter(damage)
        for val, count in counts.items():
            total_damage_at_value[val] = val * count

        # dp[i] represents the maximum damage we can achieve considering spells
        # with damage values up to 'i'.
        dp = [0] * (max_val + 1)

        # Base cases for dynamic programming
        # dp[0] is 0 as there's no damage from value 0 (and problem constraints say damage[i] >= 1)
        # If max_val is at least 1, we can consider damage value 1.
        # The maximum damage up to value 1 is simply the total damage from all spells of value 1.
        if max_val >= 1:
            dp[1] = total_damage_at_value[1]

        # Iterate from damage value 2 up to max_val
        for i in range(2, max_val + 1):
            # Option 1: Do not cast any spell with damage 'i'.
            # In this case, the maximum damage remains the same as for 'i-1'.
            option1 = dp[i-1]

            # Option 2: Cast all spells with damage 'i'.
            # If we cast spells with damage 'i', we get total_damage_at_value[i].
            # Due to the rule, we cannot cast spells with damage 'i-1'.
            # So, we add the maximum damage from spells up to 'i-2'.
            option2 = total_damage_at_value[i] + dp[i-2]

            # Choose the option that yields the maximum total damage
            dp[i] = max(option1, option2)

        # The result is the maximum damage considering all possible spell values up to max_val
        return dp[max_val]