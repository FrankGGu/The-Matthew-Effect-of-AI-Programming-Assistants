class Solution:
    MAX_VAL = 1000
    _is_prime = [True] * (MAX_VAL + 1)
    _is_prime[0] = _is_prime[1] = False
    for p in range(2, int(MAX_VAL**0.5) + 1):
        if _is_prime[p]:
            for multiple in range(p * p, MAX_VAL + 1, p):
                _is_prime[multiple] = False

    _primes_list = []
    for p in range(2, MAX_VAL + 1):
        if _is_prime[p]:
            _primes_list.append(p)

    def primeSubOperation(self, nums: list[int]) -> bool:
        prev_modified_val = 0

        for i in range(len(nums)):
            current_num = nums[i]

            if current_num < prev_modified_val + 1:
                return False

            target_val_for_p = current_num - (prev_modified_val + 1)

            found_p_to_subtract = 0

            for p_val in reversed(self._primes_list):
                if p_val <= target_val_for_p:
                    found_p_to_subtract = p_val
                    break

            prev_modified_val = current_num - found_p_to_subtract

        return True