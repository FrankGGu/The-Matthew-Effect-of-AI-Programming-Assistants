class Solution:
    def numberOfRounds(self, loginTime: str, logoutTime: str) -> int:
        def time_to_minutes(time_str):
            hh, mm = map(int, time_str.split(':'))
            return hh * 60 + mm

        login = time_to_minutes(loginTime)
        logout = time_to_minutes(logoutTime)

        if logout < login:
            logout += 24 * 60

        start_round = (login + 14) // 15 * 15
        end_round = logout // 15 * 15

        if end_round < start_round:
            return 0

        return (end_round - start_round) // 15