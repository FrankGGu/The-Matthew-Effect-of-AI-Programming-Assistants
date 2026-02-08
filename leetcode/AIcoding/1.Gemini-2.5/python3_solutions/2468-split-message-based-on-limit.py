class Solution:
    def splitMessage(self, message: str, limit: int) -> list[str]:
        n = len(message)

        def get_sum_len_digits(k: int) -> int:
            """
            Calculates the sum of lengths of string representations of numbers from 1 to k.
            For example, get_sum_len_digits(12) = len("1") + ... + len("9") + len("10") + len("11") + len("12")
            = 9*1 + 3*2 = 15
            """
            total_sum = 0
            num_digits = 1
            count_per_digit_group = 9  # Number of integers with `num_digits` (e.g., 1-9, 10-99, etc.)

            remaining_k = k
            while remaining_k > 0:
                # `take` is the count of numbers in the current digit group that are <= `remaining_k`
                take = min(remaining_k, count_per_digit_group)
                total_sum += take * num_digits
                remaining_k -= take
                count_per_digit_group *= 10
                num_digits += 1
            return total_sum

        def check(k: int) -> bool:
            """
            Checks if it's possible to split the message into `k` parts.
            """
            len_k_str = len(str(k))

            # The most restrictive part is the one with the largest suffix, which is the k-th part.
            # Its suffix length is len(str(k)) + 1 + len(str(k)).
            # This suffix must fit within the limit (i.e., its length must be <= limit).
            # If it's greater than limit, it's impossible to form this part.
            if 2 * len_k_str + 1 > limit:
                return False 

            # Calculate the total content capacity across all `k` parts.
            # The content capacity for the i-th part is `limit - (len(str(i)) + 1 + len(str(k)))`.
            # Summing this from i=1 to k:
            # sum_{i=1 to k} (limit - 1 - len(str(k)) - len(str(i)))
            # = k * (limit - 1 - len(str(k))) - sum_{i=1 to k} len(str(i))

            sum_len_i_str = get_sum_len_digits(k)

            total_content_capacity = k * (limit - 1 - len_k_str) - sum_len_i_str

            return total_content_capacity >= n

        # Iterate `k` (total number of chunks) from 1 up to `n`.
        # `n` is a safe upper bound for `k`.
        # The loop runs `O(n)` times, and `check(k)` takes `O(log k)` time.
        # Total time complexity: `O(n log n)`.
        for k in range(1, n + 1):
            if check(k):
                # Found the minimum `k` that works. Construct the result.
                result = []
                current_msg_idx = 0
                for i in range(1, k + 1):
                    len_i_str = len(str(i))
                    len_k_str = len(str(k))

                    suffix = f"{i}/{k}"
                    suffix_len = len_i_str + 1 + len_k_str

                    # Calculate how many characters from the original message can fit in this chunk.
                    # This is `limit - suffix_len`.
                    # If `limit - suffix_len` is 0, the chunk content will be empty.
                    content_capacity = limit - suffix_len

                    # Take characters from the message.
                    # If `current_msg_idx + content_capacity` exceeds `n`, it will take fewer characters,
                    # which is handled correctly by Python's slicing.
                    chunk_content = message[current_msg_idx : current_msg_idx + content_capacity]
                    result.append(chunk_content + suffix)
                    current_msg_idx += len(chunk_content)

                return result

        # If no `k` from 1 to `n` works, return an empty list.
        # This can happen if `limit` is too small to even fit a suffix.
        return []