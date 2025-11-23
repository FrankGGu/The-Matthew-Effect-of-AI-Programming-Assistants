from collections import defaultdict

def find_product_recommendation_pairs(products):
    product_users = defaultdict(set)
    for user, product in products:
        product_users[product].add(user)

    product_pairs = defaultdict(int)
    product_list = list(product_users.keys())
    n = len(product_list)

    for i in range(n):
        for j in range(i + 1, n):
            product1 = product_list[i]
            product2 = product_list[j]
            common_users = product_users[product1].intersection(product_users[product2])
            product_pairs[(product1, product2)] = len(common_users)

    result = []
    for (p1, p2), count in product_pairs.items():
        if count > 0:
            result.append((p1, p2, count))

    result.sort(key=lambda x: (-x[2], x[0], x[1]))
    return result