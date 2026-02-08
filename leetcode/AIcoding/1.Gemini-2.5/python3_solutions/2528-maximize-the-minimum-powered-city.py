class Solution:
    def maxPower(self, stations: list[int], r: int, k: int) -> int:
        n = len(stations)

        def check(min_power: int) -> bool:
            # Calculate initial power for each city from existing stations
            # using a difference array approach.
            actual_power_from_existing = [0] * n
            temp_diff = [0] * (n + 1)
            for j in range(n):
                temp_diff[max(0, j - r)] += stations[j]
                temp_diff[min(n, j + r + 1)] -= stations[j]

            current_sum = 0
            for i in range(n):
                current_sum += temp_diff[i]
                actual_power_from_existing[i] = current_sum

            # Simulate adding new stations if needed
            diff_array_new_stations = [0] * (n + 1)
            total_stations_built = 0
            current_added_power_from_new = 0

            for i in range(n):
                # Apply the effect of new stations built previously
                current_added_power_from_new += diff_array_new_stations[i]

                current_city_power = actual_power_from_existing[i] + current_added_power_from_new

                if current_city_power < min_power:
                    needed = min_power - current_city_power
                    total_stations_built += needed

                    if total_stations_built > k:
                        return False

                    # Build 'needed' stations at city i + r.
                    # These stations provide power to cities in range [i, i + 2*r].
                    # Apply immediate effect to current city i.
                    current_added_power_from_new += needed

                    # The effect of these 'needed' stations ends after city i + 2*r.
                    # So, at city i + 2*r + 1, the power should decrease by 'needed'.
                    diff_array_new_stations[min(n, i + 2 * r + 1)] -= needed

            return True

        low = 0
        high = sum(stations) + k # Maximum possible power for any single city
        ans = 0

        while low <= high:
            mid = low + (high - low) // 2
            if check(mid):
                ans = mid
                low = mid + 1
            else:
                high = mid - 1

        return ans