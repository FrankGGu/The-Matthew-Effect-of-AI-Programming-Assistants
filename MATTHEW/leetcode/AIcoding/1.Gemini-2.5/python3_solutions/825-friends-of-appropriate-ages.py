import collections

class Solution:
    def numFriendRequests(self, ages: list[int]) -> int:
        counts = collections.Counter(ages)
        total_requests = 0

        # Iterate through all possible ages for person A
        for ageA in range(1, 121):  # Ages are between 1 and 120
            if counts[ageA] == 0:
                continue

            # Iterate through all possible ages for person B
            for ageB in range(1, 121):
                if counts[ageB] == 0:
                    continue

                # Condition 1: age[B] <= 0.5 * age[A] + 7 (NOT send)
                # So, for sending a request: age[B] > 0.5 * age[A] + 7
                cond1_satisfied = (ageB > 0.5 * ageA + 7)

                # Condition 2: age[B] > age[A] (NOT send)
                # So, for sending a request: age[B] <= age[A]
                cond2_satisfied = (ageB <= ageA)

                # Condition 3: age[B] > 100 && age[A] < 100 (NOT send)
                # So, for sending a request: NOT (age[B] > 100 and age[A] < 100)
                cond3_satisfied = not (ageB > 100 and ageA < 100)

                # If all conditions for sending a request are met
                if cond1_satisfied and cond2_satisfied and cond3_satisfied:
                    if ageA == ageB:
                        # If A and B are of the same age, any person of ageA can send
                        # a request to any other person of ageA.
                        # The number of pairs (A, B) where A != B is N * (N - 1)
                        total_requests += counts[ageA] * (counts[ageA] - 1)
                    else:
                        # If A and B are of different ages, any person of ageA can send
                        # a request to any person of ageB.
                        total_requests += counts[ageA] * counts[ageB]

        return total_requests