var seasonalSalesAnalysis = function(sales, products) {
    const productMap = new Map();
    for (const product of products) {
        productMap.set(product.product_id, product.category);
    }

    const salesByQuarterCategory = new Map();

    for (const sale of sales) {
        const category = productMap.get(sale.product_id);
        if (category === undefined) {
            continue;
        }

        const saleDate = new Date(sale.sale_date);
        const month = saleDate.getMonth();

        let quarter;
        if (month >= 0 && month <= 2) {
            quarter = 1;
        } else if (month >= 3 && month <= 5) {
            quarter = 2;
        } else if (month >= 6 && month <= 8) {
            quarter = 3;
        } else {
            quarter = 4;
        }

        const salesAmount = sale.quantity * sale.price;
        const key = `${category}-${quarter}`;

        salesByQuarterCategory.set(key, (salesByQuarterCategory.get(key) || 0) + salesAmount);
    }

    const result = [];
    for (const [key, total_sales_amount] of salesByQuarterCategory.entries()) {
        const [category, quarterStr] = key.split('-');
        result.push({
            category: category,
            quarter: parseInt(quarterStr),
            total_sales_amount: total_sales_amount
        });
    }

    return result;
};