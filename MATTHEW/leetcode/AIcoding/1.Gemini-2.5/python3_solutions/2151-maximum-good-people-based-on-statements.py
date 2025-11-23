class Solution:
    def maximumGood(self, statements: list[list[int]]) -> int:
        n = len(statements)
        max_good_people = 0

        # Iterate through all possible assignments of good/bad to people
        # A bitmask represents an assignment: i-th bit is 1 if person i is good, 0 if bad
        for i in range(1 << n):
            current_assignment = i
            is_consistent = True

            # Check consistency for this assignment
            for p1_idx in range(n):
                # If person p1_idx is assumed to be good in the current assignment
                if (current_assignment >> p1_idx) & 1:
                    # All statements made by p1_idx must be true
                    for p2_idx in range(n):
                        statement = statements[p1_idx][p2_idx]
                        if statement != 2:  # If p1_idx made a statement about p2_idx
                            p2_is_good_in_assignment = (current_assignment >> p2_idx) & 1

                            # If p1_idx says p2_idx is good (statement == 1)
                            # but p2_idx is bad in our assignment, it's inconsistent
                            if statement == 1 and p2_is_good_in_assignment == 0:
                                is_consistent = False
                                break
                            # If p1_idx says p2_idx is bad (statement == 0)
                            # but p2_idx is good in our assignment, it's inconsistent
                            elif statement == 0 and p2_is_good_in_assignment == 1:
                                is_consistent = False
                                break
                if not is_consistent:
                    break

            # If the assignment is consistent, count the number of good people
            if is_consistent:
                good_people_count = 0
                for p_idx in range(n):
                    if (current_assignment >> p_idx) & 1:
                        good_people_count += 1
                max_good_people = max(max_good_people, good_people_count)

        return max_good_people