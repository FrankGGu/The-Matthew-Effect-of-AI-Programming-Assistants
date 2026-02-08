class Solution:
    def countDaysTogether(self, alice_arrive: str, alice_leave: str, bob_arrive: str, bob_leave: str) -> int:
        days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

        prefix_sum_days = [0] * 13
        for i in range(1, 13):
            prefix_sum_days[i] = prefix_sum_days[i-1] + days_in_month[i-1]

        def convert_to_day_num(date_str):
            month, day = map(int, date_str.split('-'))
            return prefix_sum_days[month-1] + day

        alice_arrive_day = convert_to_day_num(alice_arrive)
        alice_leave_day = convert_to_day_num(alice_leave)
        bob_arrive_day = convert_to_day_num(bob_arrive)
        bob_leave_day = convert_to_day_num(bob_leave)

        overlap_start = max(alice_arrive_day, bob_arrive_day)
        overlap_end = min(alice_leave_day, bob_leave_day)

        return max(0, overlap_end - overlap_start + 1)