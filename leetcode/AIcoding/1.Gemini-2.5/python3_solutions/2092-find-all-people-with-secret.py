import collections

class Solution:
    def findAllPeople(self, n: int, meetings: list[list[int]], firstPerson: int) -> list[int]:

        class DSU:
            def __init__(self, n_nodes):
                self.parent = list(range(n_nodes))

            def find(self, i):
                if self.parent[i] == i:
                    return i
                self.parent[i] = self.find(self.parent[i])
                return self.parent[i]

            def union(self, i, j):
                root_i = self.find(i)
                root_j = self.find(j)
                if root_i != root_j:
                    self.parent[root_j] = root_i
                    return True
                return False

            def reset(self, people_to_reset):
                for p in people_to_reset:
                    self.parent[p] = p

        dsu = DSU(n)

        # Person 0 and firstPerson initially know the secret.
        # Union them to ensure they are in the same secret-knowing component.
        dsu.union(0, firstPerson)

        # Group meetings by time
        time_to_meetings = collections.defaultdict(list)
        for p1, p2, time in meetings:
            time_to_meetings[time].append((p1, p2))

        # Sort unique meeting times to process chronologically
        sorted_times = sorted(time_to_meetings.keys())

        # Process meetings for each time step
        for time in sorted_times:
            current_meetings = time_to_meetings[time]

            people_at_this_time = set()
            for p1, p2 in current_meetings:
                people_at_this_time.add(p1)
                people_at_this_time.add(p2)
                # Perform unions for all meetings at this specific time
                dsu.union(p1, p2)

            # After all unions for this time are done,
            # check which people in these meetings learned the secret.
            # A person learns the secret if their component is connected to person 0's component.
            # If they did not learn the secret, their DSU state needs to be reset
            # so they don't carry over connections to the next time step.

            people_to_reset_parents = []
            for p in people_at_this_time:
                # If a person's root is not the same as person 0's root,
                # it means they did not learn the secret at this time.
                if dsu.find(p) != dsu.find(0):
                    people_to_reset_parents.append(p)

            # Reset the parents of those who did not learn the secret at this time.
            dsu.reset(people_to_reset_parents)

        # Finally, collect all people whose component is connected to person 0's component.
        # These are all the people who eventually know the secret.
        result = []
        for i in range(n):
            if dsu.find(i) == dsu.find(0):
                result.append(i)

        return result