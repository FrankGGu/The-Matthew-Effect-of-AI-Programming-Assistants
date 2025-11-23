import collections
import bisect

class TopVotedCandidate:

    def __init__(self, persons: list[int], times: list[int]):
        self.times = times
        self.leaders = []

        votes = collections.defaultdict(int)

        current_leader = -1
        max_votes = 0

        for i in range(len(persons)):
            p = persons[i]

            votes[p] += 1

            if votes[p] >= max_votes:
                # If person p has strictly more votes, they become the new leader.
                # If person p has the same number of votes as the current max,
                # and p just received a vote (at the current time times[i]),
                # then p's last vote time is times[i].
                # The previous current_leader's last vote time must be strictly less than times[i]
                # (since only one person votes at a given time, and times are strictly increasing).
                # Therefore, p wins the tie-break by having the largest vote time.
                max_votes = votes[p]
                current_leader = p

            self.leaders.append(current_leader)

    def query(self, t: int) -> int:
        idx = bisect.bisect_right(self.times, t) - 1
        return self.leaders[idx]