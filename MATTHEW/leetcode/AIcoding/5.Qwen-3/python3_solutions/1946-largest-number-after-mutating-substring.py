class Solution:
    def maximumNumber(self, number: str, mapping: List[int]) -> str:
        number = list(number)
        for i in range(len(number)):
            if mapping[int(number[i])] > int(number[i]):
                number[i] = str(mapping[int(number[i])])
        return ''.join(number)