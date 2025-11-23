class Solution:
    def rankTeams(self, votes: list[str]) -> str:
        if not votes:
            return ""

        num_ranks = len(votes[0])

        team_scores = {team_char: [0] * num_ranks for team_char in votes[0]}

        for vote in votes:
            for rank_idx, team_char in enumerate(vote):
                team_scores[team_char][rank_idx] += 1

        sorted_teams = sorted(team_scores.keys(), key=lambda team: ([-count for count in team_scores[team]], team))

        return "".join(sorted_teams)