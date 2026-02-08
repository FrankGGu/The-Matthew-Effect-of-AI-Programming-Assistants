class Solution:
    def eatenPizzas(self, pizzas: List[int]) -> int:
        count = 0
        while True:
            min_pizza = min(pizzas)
            if min_pizza == 0:
                break
            for i in range(len(pizzas)):
                if pizzas[i] == min_pizza:
                    pizzas[i] -= 1
                    count += 1
                    break
        return count