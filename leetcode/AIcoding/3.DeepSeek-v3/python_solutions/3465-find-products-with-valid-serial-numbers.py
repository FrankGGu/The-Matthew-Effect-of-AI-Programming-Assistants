class Solution:
    def findValidProducts(self, products: List[List[str]], serials: List[str]) -> List[List[str]]:
        valid_products = []
        for product in products:
            name, serial = product
            if len(serial) != 8:
                continue
            if not serial.isalnum():
                continue
            if not any(c.isupper() for c in serial):
                continue
            if not any(c.islower() for c in serial):
                continue
            if not any(c.isdigit() for c in serial):
                continue
            if len(set(serial)) < 5:
                continue
            valid_products.append(product)
        return valid_products