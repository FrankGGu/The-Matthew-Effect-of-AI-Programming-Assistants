class Solution:
    def countSeniors(self, details: list[str]) -> int:
        senior_count = 0
        for passenger_details in details:
            age_str = passenger_details[11:13]
            age = int(age_str)
            if age > 60:
                senior_count += 1
        return senior_count