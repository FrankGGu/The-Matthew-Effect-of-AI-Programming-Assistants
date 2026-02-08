from collections import defaultdict

class Solution:
    def rankTeams(self, votes: list[str]) -> str:
        if not votes:
            return ""

        num_teams = len(votes[0])
        team_ranks = defaultdict(lambda: [0] * num_teams)

        for vote in votes:
            for i, team in enumerate(vote):
                team_ranks[team][i] += 1

        teams = list(votes[0])

        teams.sort(key=lambda team: team_ranks[team], reverse=True)

        return "".join(teams)