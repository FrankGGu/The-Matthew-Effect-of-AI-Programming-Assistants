func reachingPoints(sx int, sy int, tx int, ty int) bool {
	for tx >= sx && ty >= sy {
		if tx == sx && ty == sy {
			return true
		}
		if tx == ty {
			return false
		}

		if tx > ty {
			// We are reducing tx.
			// If ty is already at sy, we must reach sx by subtracting ty.
			if ty == sy {
				return (tx >= sx && (tx-sx)%ty == 0)
			}
			// Otherwise, perform modulo reduction on tx.
			// If tx is a multiple of ty, it means we repeatedly added ty to tx.
			// The previous state would be (ty, ty) if tx > ty.
			// So, if tx % ty == 0, tx effectively becomes ty.
			if tx%ty == 0 {
				tx = ty
			} else {
				tx %= ty
			}
		} else { // ty > tx
			// We are reducing ty.
			// If tx is already at sx, we must reach sy by subtracting tx.
			if tx == sx {
				return (ty >= sy && (ty-sy)%tx == 0)
			}
			// Otherwise, perform modulo reduction on ty.
			// If ty is a multiple of tx, it means we repeatedly added tx to ty.
			// The previous state would be (tx, tx) if ty > tx.
			// So, if ty % tx == 0, ty effectively becomes tx.
			if ty%tx == 0 {
				ty = tx
			} else {
				ty %= tx
			}
		}
	}
	return false
}