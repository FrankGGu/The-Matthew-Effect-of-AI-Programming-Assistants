class Solution:
    def largestMultipleOfThree(self, digits: list[int]) -> str:
        counts = [0] * 10
        for d in digits:
            counts[d] += 1

        total_sum = sum(d * c for d, c in enumerate(counts))

        def build_number(current_counts):
            if not current_counts:
                return ""

            res_list = []
            for d in range(9, -1, -1):
                res_list.extend([str(d)] * current_counts[d])

            if not res_list:
                return ""
            if res_list[0] == '0':
                return '0'
            return "".join(res_list)

        best_counts = []
        best_num_str = ""

        if total_sum % 3 == 0:
            best_counts = counts
            best_num_str = build_number(best_counts)
        elif total_sum % 3 == 1:
            option1_counts = None
            option2_counts = None

            for d in [1, 4, 7]:
                if counts[d] > 0:
                    temp_counts = list(counts)
                    temp_counts[d] -= 1
                    option1_counts = temp_counts
                    break

            rem2_digits = []
            for d in [2, 5, 8]:
                rem2_digits.extend([d] * counts[d])
            rem2_digits.sort()

            if len(rem2_digits) >= 2:
                temp_counts = list(counts)
                temp_counts[rem2_digits[0]] -= 1
                temp_counts[rem2_digits[1]] -= 1
                option2_counts = temp_counts

            if option1_counts is not None:
                current_num_str = build_number(option1_counts)
                if current_num_str != "":
                    if best_num_str == "" or \
                       len(current_num_str) > len(best_num_str) or \
                       (len(current_num_str) == len(best_num_str) and current_num_str > best_num_str):
                        best_num_str = current_num_str
                        best_counts = option1_counts

            if option2_counts is not None:
                current_num_str = build_number(option2_counts)
                if current_num_str != "":
                    if best_num_str == "" or \
                       len(current_num_str) > len(best_num_str) or \
                       (len(current_num_str) == len(best_num_str) and current_num_str > best_num_str):
                        best_num_str = current_num_str
                        best_counts = option2_counts

        else: # total_sum % 3 == 2
            option1_counts = None
            option2_counts = None

            for d in [2, 5, 8]:
                if counts[d] > 0:
                    temp_counts = list(counts)
                    temp_counts[d] -= 1
                    option1_counts = temp_counts
                    break

            rem1_digits = []
            for d in [1, 4, 7]:
                rem1_digits.extend([d] * counts[d])
            rem1_digits.sort()

            if len(rem1_digits) >= 2:
                temp_counts = list(counts)
                temp_counts[rem1_digits[0]] -= 1
                temp_counts[rem1_digits[1]] -= 1
                option2_counts = temp_counts

            if option1_counts is not None:
                current_num_str = build_number(option1_counts)
                if current_num_str != "":
                    if best_num_str == "" or \
                       len(current_num_str) > len(best_num_str) or \
                       (len(current_num_str) == len(best_num_str) and current_num_str > best_num_str):
                        best_num_str = current_num_str
                        best_counts = option1_counts

            if option2_counts is not None:
                current_num_str = build_number(option2_counts)
                if current_num_str != "":
                    if best_num_str == "" or \
                       len(current_num_str) > len(best_num_str) or \
                       (len(current_num_str) == len(best_num_str) and current_num_str > best_num_str):
                        best_num_str = current_num_str
                        best_counts = option2_counts

        return best_num_str