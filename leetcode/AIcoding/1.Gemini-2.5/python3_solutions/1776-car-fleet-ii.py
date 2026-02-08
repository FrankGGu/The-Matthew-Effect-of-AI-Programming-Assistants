import collections

class Solution:
    def getCollisionTimes(self, cars: list[list[int]]) -> list[float]:
        n = len(cars)
        ans = [-1.0] * n

        # Stack stores indices of cars (or fleets) from right to left.
        # The stack maintains a property that for any two adjacent cars j (bottom) and k (top) on the stack,
        # speed[j] > speed[k]. This ensures that cars on the stack are potential collision targets
        # for cars to their left, and the stack top is the closest relevant target.
        # If a car j on the stack would be caught by a car i to its left,
        # but j itself would collide with k (further right on stack) before i catches j,
        # then j is removed from the stack because i would effectively collide with the fleet (j, k, ...).

        stack = collections.deque() # Using deque for efficient append/pop from right (top of stack)

        # Process cars from right to left
        for i in range(n - 1, -1, -1):
            p_i, s_i = cars[i]

            # While stack is not empty, evaluate car 'i' against the top of the stack 'j'
            while stack:
                j = stack[-1]
                p_j, s_j = cars[j]

                # Condition 1: Current car 'i' is slower or equal speed than car 'j'
                # If s_i <= s_j, car 'i' will never catch car 'j'.
                # In this case, 'j' is not a candidate for 'i'. Furthermore, 'j' is also not a candidate
                # for any car 'k' to the left of 'i' that is slower or equal speed to 'i'.
                # If 'k' is faster than 'i', 'k' would collide with 'i' first.
                # So, 'j' is irrelevant for 'i' and any cars to its left. Pop 'j'.
                if s_i <= s_j:
                    stack.pop()
                else:
                    # Condition 2: Current car 'i' is faster than car 'j' (s_i > s_j)
                    # Car 'i' can catch car 'j'. Calculate the time it would take.
                    t_ij = (p_j - p_i) / (s_i - s_j)

                    # Check if car 'j' itself collides with its next collision partner (stored in ans[j])
                    # before 'i' collides with 'j'.
                    # ans[j] stores the collision time of car 'j' with its first collision partner to its right.
                    # If ans[j] is -1.0, car 'j' never collides with anything to its right.
                    #
                    # If ans[j] is -1.0 OR t_ij <= ans[j]:
                    # This means 'i' collides with 'j' (or the fleet 'j' represents) either before 'j'
                    # collides with anything else, or 'j' never collides.
                    # So, 'j' is the first car 'i' collides with.
                    if ans[j] == -1.0 or t_ij <= ans[j]:
                        ans[i] = t_ij
                        break # Found the first collision for car 'i', exit the while loop
                    else:
                        # If t_ij > ans[j]:
                        # This means car 'j' collides with its next partner (say, car 'k' further right)
                        # at time ans[j], which happens *before* 'i' would collide with 'j'.
                        # So, by the time 'i' reaches 'j', 'j' would already be part of a fleet with 'k'
                        # (moving at speed s_k). Thus, 'j' (as a single car) is not the first car 'i' collides with.
                        # Pop 'j' and re-evaluate 'i' against the new top of the stack.
                        stack.pop()

            # After evaluating against all relevant cars on the stack, push current car 'i'
            # onto the stack as a potential collision target for cars to its left.
            stack.append(i)

        return ans