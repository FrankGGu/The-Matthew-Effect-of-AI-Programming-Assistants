class Solution:
    def encrypt(self, nums: list[int], key: int) -> list[int]:
        encrypted_nums = []
        for num in nums:
            encrypted_nums.append(num ^ key)
        return encrypted_nums