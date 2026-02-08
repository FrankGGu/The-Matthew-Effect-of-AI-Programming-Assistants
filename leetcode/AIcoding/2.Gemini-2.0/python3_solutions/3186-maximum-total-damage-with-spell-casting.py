class Solution:
    def maxTotalDamage(self, damage: list[int], spellPower: list[int], armor: int) -> int:
        damage.sort()
        spellPower.sort()
        n = len(damage)
        m = len(spellPower)
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + damage[i]

        def calculate_damage(power):
            left = 0
            right = n - 1
            idx = -1
            while left <= right:
                mid = (left + right) // 2
                if damage[mid] <= power:
                    idx = mid
                    left = mid + 1
                else:
                    right = mid - 1

            if idx == -1:
                return prefix_sum[n] - max(0, prefix_sum[n] - armor)

            total_damage = prefix_sum[n] - prefix_sum[idx + 1] + min(power, damage[idx]) + prefix_sum[idx]
            return total_damage - max(0, total_damage - armor)

        max_damage = 0
        for power in spellPower:
            max_damage = max(max_damage, calculate_damage(power))

        return max_damage