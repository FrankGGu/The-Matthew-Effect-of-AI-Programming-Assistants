type Products struct {
	product_id string
	product_name string
}

type ValidSerial struct {
	product_id string
}

func findProducts() string {
	return `SELECT p.product_name
FROM Products p
JOIN ValidSerial v ON p.product_id = v.product_id;`
}