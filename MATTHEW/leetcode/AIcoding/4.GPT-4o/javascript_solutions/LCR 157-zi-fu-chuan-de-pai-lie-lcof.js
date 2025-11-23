function rearrangeProducts(products) {
    return products.sort((a, b) => a.price - b.price || a.name.localeCompare(b.name));
}