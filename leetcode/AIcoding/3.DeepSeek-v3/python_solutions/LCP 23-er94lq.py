class Solution:
    def isMagic(self, target: List[int]) -> bool:
        n = len(target)
        arr = list(range(1, n + 1))

        def check(k):
            temp = arr.copy()
            for _ in range(n):
                # Step 1: 选牌
                remaining = temp[k:]
                selected = temp[:k]
                # Step 2: 洗牌
                temp = []
                for i in range(len(remaining)):
                    if i % 2 == 0:
                        temp.append(remaining[i])
                for i in range(len(remaining)):
                    if i % 2 == 1:
                        temp.append(remaining[i])
                temp = selected + temp
                # 检查是否匹配
                if temp == target:
                    return True
                if len(temp) < k:
                    break
            return False

        for k in range(1, n + 1):
            if check(k):
                return True
        return False