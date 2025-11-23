import math

class Solution:
    def minimumDamage(self, damage: list[int], bobHealth: int) -> int:
        damage.sort()
        n = len(damage)

        # dp stores all achievable sums of regular attacks.
        # Each element 's' in dp represents a sum of damage from a subset of regular attacks.
        # We want to find the minimum total damage to reach bobHealth.
        # This involves two cases for each achievable sum 's' and current attack 'd':
        # 1. Use 'd' as a regular attack: total damage is s + d.
        # 2. Use 'd' as a regular attack AND use the special attack (where 'd' is the maximum regular attack used so far):
        #    total damage is s + d (regular) + d (special) = s + 2*d.

        # Initialize dp with 0 (representing no attacks used, 0 damage dealt).
        dp = {0}

        # Initialize the minimum overall damage found so far to infinity.
        min_overall_damage = float('inf')

        for d in damage:
            next_dp = set(dp) # Start with all sums achievable before considering 'd'

            for s in dp:
                # Case 1: Use 'd' as a regular attack.
                # The total damage from regular attacks is s + d.
                current_regular_damage = s + d

                # If this sum alone is enough to defeat Bob, update min_overall_damage.
                if current_regular_damage >= bobHealth:
                    min_overall_damage = min(min_overall_damage, current_regular_damage)

                # Add this new sum to the set of achievable sums for future iterations.
                # This sum 'current_regular_damage' can be a base for further regular attacks,
                # or its 'd' component can be the maximum for a future special attack consideration.
                next_dp.add(current_regular_damage)

                # Case 2: Use 'd' as a regular attack, AND use the special attack.
                # In this scenario, 'd' is considered the maximum regular attack used among 's' and 'd'.
                # The special attack deals 'd' damage.
                # Total damage: s (from previous regular attacks) + d (current regular attack) + d (special attack) = s + 2*d.
                total_damage_with_special = s + 2 * d

                # If this total damage is enough to defeat Bob, update min_overall_damage.
                if total_damage_with_special >= bobHealth:
                    min_overall_damage = min(min_overall_damage, total_damage_with_special)

            dp = next_dp

        # If min_overall_damage is still infinity, it means Bob cannot be defeated.
        if min_overall_damage == float('inf'):
            return -1
        else:
            return min_overall_damage