class Solution:
    def melt(self, data):
        result = []
        for key, values in data.items():
            for value in values:
                result.append({'key': key, 'value': value})
        return result