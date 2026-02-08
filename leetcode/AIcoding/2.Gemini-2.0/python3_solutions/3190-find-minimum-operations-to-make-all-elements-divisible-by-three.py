from math import gcd

class Solution:
    def minOperations(self, nums: list[int]) -> int:
        g = 0
        for num in nums:
            g = gcd(g, num)

        if g % 3 != 0:
            return -1

        ones = 0
        twos = 0

        for num in nums:
            if num % 3 == 1:
                ones += 1
            elif num % 3 == 2:
                twos += 1

        ans = float('inf')

        if ones >= 1 and twos >= 1:
            ans = min(ans, 2)
        if ones >= 2:
            ans = min(ans, 2)
        if twos >= 2:
            ans = min(ans, 2)
        if ones >= 1:
            ans = min(ans, 1)
        if twos >= 1:
            ans = min(ans, 1)

        ones_needed = 0
        twos_needed = 0

        if g % 3 == 0:

            count1 = 0
            count2 = 0

            for num in nums:
                if num % 3 == 1:
                  count1 += 1
                elif num % 3 == 2:
                  count2 += 1

            if count1 >= 1 and count2 >= 1:
              ans = min(ans, 2)
            elif count1 >= 2:
              ans = min(ans, 2)
            elif count2 >= 2:
              ans = min(ans, 2)
            elif count1 >= 1:
              ans = min(ans, 1)
            elif count2 >= 1:
              ans = min(ans, 1)
            else:
              return -1

        one_count = 0
        two_count = 0

        for num in nums:
          if num % 3 == 1:
            one_count += 1
          elif num % 3 == 2:
            two_count += 1

        ans = float('inf')

        if one_count >= 1 and two_count >= 1:
          ans = min(ans, 2)

        if one_count >= 2:
          ans = min(ans, 2)

        if two_count >= 2:
          ans = min(ans, 2)

        if one_count >= 1:
          ans = min(ans, 1)

        if two_count >= 1:
          ans = min(ans, 1)

        total_sum = sum(nums)

        if total_sum % 3 == 0:
          return 0

        one_c = 0
        two_c = 0

        for num in nums:
          if num % 3 == 1:
            one_c += 1
          elif num % 3 == 2:
            two_c += 1

        if total_sum % 3 == 1:
          if one_c >= 1:
            ans = min(ans, 1)
          if two_c >= 2:
            ans = min(ans, 2)

        if total_sum % 3 == 2:
          if two_c >= 1:
            ans = min(ans, 1)
          if one_c >= 2:
            ans = min(ans, 2)

        if ans == float('inf'):
            return -1

        return ans