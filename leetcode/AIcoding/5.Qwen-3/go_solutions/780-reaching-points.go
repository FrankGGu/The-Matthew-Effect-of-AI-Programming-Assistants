package main

func reachPoints(sx int, sy int, tx int, ty int) bool {
	for tx >= sx && ty >= sy {
		if tx == sx && ty == sy {
			return true
		}
		if tx > ty {
			if ty > sy {
				tx = tx % ty
			} else {
				break
			}
		} else {
			if tx > sx {
				ty = ty % tx
			} else {
				break
			}
		}
	}
	return tx == sx && ty == sy
}