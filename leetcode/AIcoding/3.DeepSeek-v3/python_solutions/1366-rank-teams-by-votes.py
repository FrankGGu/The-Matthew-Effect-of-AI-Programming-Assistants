class Solution:
    def rankTeams(self, votes: List[str]) -> str:
        count = {team: [0] * len(votes[0]) for team in votes[0]}
        for vote in votes:
            for i, team in enumerate(vote):
                count[team][i] -= 1
        teams = sorted(votes[0])
        teams.sort(key=lambda x: count[x])
        return ''.join(teams)